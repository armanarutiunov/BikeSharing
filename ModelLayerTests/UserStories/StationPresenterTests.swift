//
//  StationPresenterTests.swift
//  ModelLayerTests
//
//  Created by Arman Arutyunov on 23/03/2018.
//  Copyright © 2018 Arman Arutyunov. All rights reserved.
//

import XCTest
import RxSwift

@testable import ModelLayer

class StationPresenterTests: XCTestCase {
    
    var station: Station!
    var bookingService: MockBookingService!
    var interactor: StationInteractor!
    var viewIO: MockStationViewIO!
    var sut: StationPresenter<MockStationViewIO>!
    var navigator: MockStationNavigator!
    let disposeBag = DisposeBag()
    
    override func setUp() {
        super.setUp()
        station = Station(id: 1,
                          location: Location(latitude: 1, longtitude: 1, address: "address"),
                          bikes: [Bike(id: 2, stationId: 1, name: "bikeName", frameColor: .blue, pin: 1111),
                                  Bike(id: 3, stationId: 1, name: "bikeName", frameColor: .blue, pin: 1111),
                                  Bike(id: 4, stationId: 1, name: "bikeName", frameColor: .blue, pin: 1111)])
        bookingService = MockBookingService()
        interactor = StationInteractor(executors: TestBlockingExecutors(), bookingService: bookingService)
        viewIO = MockStationViewIO()
        navigator = MockStationNavigator()
        sut = StationPresenter(interactor: interactor, navigator: navigator, station: station)
    }
    
    func testView() {
        //Given
        var addressIsRight = false
        var stationIdIsRight = false
        viewIO._showAddress = { [weak self] in addressIsRight = $0 == self?.station.location.address }
        viewIO._showStationId = { [weak self] in
            guard let `self` = self else { return }
            stationIdIsRight = $0 == "\(self.station.id)" }
        
        //When
        sut.setup()
        sut.attachView(viewIO: viewIO).disposed(by: disposeBag)
        
        //Then
        XCTAssertTrue(addressIsRight)
        XCTAssertTrue(stationIdIsRight)
    }
    
    func testParkButtonToggleEnable() {
        //Given
        var enabled = false
        viewIO._toggleParkButton = {enabled = $0}
        
        //When
        sut.setup()
        sut.attachView(viewIO: viewIO).disposed(by: disposeBag)
        bookingService._getBookedBike.onNext(nil)
        bookingService._getRidingBike.onNext(self.station.bikes.first)
        
        //Then
        XCTAssertTrue(enabled)
    }
    
    func testParkButtonToggleDisabled() {
        //Given
        var enabled = true
        viewIO._toggleParkButton = {enabled = $0}
        
        //When
        sut.setup()
        sut.attachView(viewIO: viewIO).disposed(by: disposeBag)
        bookingService._getBookedBike.onNext(nil)
        bookingService._getRidingBike.onNext(nil)
        
        //Then
        XCTAssertFalse(enabled)
    }
    
    func testRidingBike() {
        // When
        var freeBikeCounterUpdatedCorrectly = false
        var freeSpaceCounterUpdatedCorrectly = false
        viewIO._updateFreeBikesCounter = { [weak self] in
            guard let `self` = self else { return }
            freeBikeCounterUpdatedCorrectly = $0 == self.station.bikes.count - 1
        }
        viewIO._updateFreeSpaceCounter = { [weak self] in
            guard let `self` = self else { return }
            freeSpaceCounterUpdatedCorrectly = $0 == self.station.capacity - (self.station.bikes.count - 1)
        }
        
        //When
        sut.setup()
        sut.attachView(viewIO: viewIO).disposed(by: disposeBag)
        bookingService._getBookedBike.onNext(nil)
        bookingService._getRidingBike.onNext(self.station.bikes[1])
        
        // Then
        XCTAssertTrue(freeBikeCounterUpdatedCorrectly)
        XCTAssertTrue(freeSpaceCounterUpdatedCorrectly)
    }
    
    func testBikeIsBooked() {
        // Given
        var bookedBikeMarked = false
        var freeBikeCounterUpdatedCorrectly = false
        var freeSpaceCounterUpdatedCorrectly = false
        viewIO._markBikeAsBooked = { _ in bookedBikeMarked = true }
        viewIO._updateFreeBikesCounter = { [weak self] in
            guard let `self` = self else { return }
            freeBikeCounterUpdatedCorrectly = $0 == self.station.bikes.count - 1
        }
        viewIO._updateFreeSpaceCounter = { [weak self] in
            guard let `self` = self else { return }
            freeSpaceCounterUpdatedCorrectly = $0 == self.station.capacity - (self.station.bikes.count - 1)
        }
        
        //When
        sut.setup()
        sut.attachView(viewIO: viewIO).disposed(by: disposeBag)
        bookingService._getBookedBike.onNext(self.station.bikes[1])
        bookingService._getRidingBike.onNext(nil)
        
        // Then
        XCTAssertTrue(bookedBikeMarked)
        XCTAssertTrue(freeBikeCounterUpdatedCorrectly)
        XCTAssertTrue(freeSpaceCounterUpdatedCorrectly)
    }
    
    func testBikeIsBookedAtDifferentStation() {
        // Given
        var bookedBikeMarked = false
        var freeBikeCounterUpdatedCorrectly = false
        var freeSpaceCounterUpdatedCorrectly = false
        viewIO._markBikeAsBooked = { _ in bookedBikeMarked = true }
        viewIO._updateFreeBikesCounter = { [weak self] in
            guard let `self` = self else { return }
            freeBikeCounterUpdatedCorrectly = $0 == self.station.bikes.count
        }
        viewIO._updateFreeSpaceCounter = { [weak self] in
            guard let `self` = self else { return }
            freeSpaceCounterUpdatedCorrectly = $0 == self.station.capacity - self.station.bikes.count
        }
        
        //When
        sut.setup()
        sut.attachView(viewIO: viewIO).disposed(by: disposeBag)
        bookingService._getBookedBike.onNext(Bike(id: 4, stationId: 2, name: "bike", frameColor: .blue, pin: 2222))
        bookingService._getRidingBike.onNext(nil)
        
        // Then
        XCTAssertFalse(bookedBikeMarked)
        XCTAssertTrue(freeBikeCounterUpdatedCorrectly)
        XCTAssertTrue(freeSpaceCounterUpdatedCorrectly)
    }
    
    func testUnmarkBike() {
        //Given
        var unmarkedBike = false
        var freeBikeCounterUpdatedCorrectly = false
        var freeSpaceCounterUpdatedCorrectly = false
        viewIO._unmarkBikeAsBooked = {  unmarkedBike = true }
        viewIO._updateFreeBikesCounter = { [weak self] in
            guard let `self` = self else { return }
            freeBikeCounterUpdatedCorrectly = $0 == self.station.bikes.count
        }
        viewIO._updateFreeSpaceCounter = { [weak self] in
            guard let `self` = self else { return }
            freeSpaceCounterUpdatedCorrectly = $0 == self.station.capacity - self.station.bikes.count
        }
        
        //When
        sut.setup()
        sut.attachView(viewIO: viewIO).disposed(by: disposeBag)
        sut.markedBike.accept(station.bikes.first!)
        bookingService._getBookedBike.onNext(nil)
        bookingService._getRidingBike.onNext(nil)
        
        //Then
        XCTAssertTrue(unmarkedBike)
        XCTAssertTrue(freeBikeCounterUpdatedCorrectly)
        XCTAssertTrue(freeSpaceCounterUpdatedCorrectly)
    }
    
    func testBookBike() {
        //Given
        var successfullyBooked = false
        navigator._toBooking = { successfullyBooked = true}
        
        //When
        sut.setup()
        sut.attachView(viewIO: viewIO).disposed(by: disposeBag)
        bookingService._getBookedBike.onNext(nil)
        bookingService._getRidingBike.onNext(nil)
        viewIO._bookBike.onNext(0)
        
        //Then
        DispatchQueue.main.asyncAfter(deadline: .now()+1) { [weak self] in
            self?.eventually { XCTAssertTrue(successfullyBooked) }
        }
    }
    
    func testShowRidingAlert() {
        //Given
        var showedAlert = false
        viewIO._showRidingAlert = { showedAlert = true}
        
        //When
        sut.setup()
        sut.attachView(viewIO: viewIO).disposed(by: disposeBag)
        bookingService._getBookedBike.onNext(nil)
        bookingService._getRidingBike.onNext(self.station.bikes.first)
        viewIO._bookBike.onNext(0)
        
        //Then
        DispatchQueue.main.asyncAfter(deadline: .now()+1) { [weak self] in
            self?.eventually { XCTAssertTrue(showedAlert) }
        }
    }
    
    func testParkingBike() {
        //Given
        var showedAlert = false
        var freeBikeCounterUpdatedCorrectly = false
        var freeSpaceCounterUpdatedCorrectly = false
        viewIO._showAlertParkedBike = { showedAlert = true }
        viewIO._updateFreeBikesCounter = { [weak self] in
            guard let `self` = self else { return }
            freeBikeCounterUpdatedCorrectly = $0 == self.station.bikes.count + 1
        }
        viewIO._updateFreeSpaceCounter = { [weak self] in
            guard let `self` = self else { return }
            freeSpaceCounterUpdatedCorrectly = $0 == self.station.capacity - (self.station.bikes.count + 1)
        }
        
        //When
        sut.setup()
        sut.attachView(viewIO: viewIO).disposed(by: disposeBag)
        bookingService._getBookedBike.onNext(nil)
        bookingService._getRidingBike.onNext(Bike(id: 4, stationId: 2, name: "bike", frameColor: .blue, pin: 2222))
        viewIO._parkBike.onNext(())
        
        //Then
        DispatchQueue.main.asyncAfter(deadline: .now()+1) { [weak self] in
            self?.eventually {
                XCTAssertTrue(showedAlert)
                XCTAssertTrue(freeBikeCounterUpdatedCorrectly)
                XCTAssertTrue(freeSpaceCounterUpdatedCorrectly)
            }
        }
    }
    
}
