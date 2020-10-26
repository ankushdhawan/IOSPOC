//
//  CountryViewModelTest.swift
//  POCTests
//
//  Created by Ankush Dhawan on 10/25/20.
//  Copyright © 2020 Reliance. All rights reserved.
//
import Foundation
import UIKit
@testable import IosPoc
import XCTest

class CountryDetailViewModelTests: XCTestCase
{
    var sut: CountryViewModel!
    var model:CountryModel!

    var mockAPIService: MockService!
    override func setUp() {
        super.setUp()
        //Create View Model Object
       sut = CountryViewModel()

    

    }
    override func tearDown() {
        sut = nil
        mockAPIService = nil
        super.tearDown()
    }
    func testMockApi()
    {
        mockAPIService = MockService()
        var isSuccess = false
        var count = 0
        let client = CountryDetailApiClient(client: mockAPIService)
        let resource = GenericResource(path: "Country", method:.GET)
        let expect = XCTestExpectation(description: "reload closure triggered")
       client.fetchCountryData(resource: resource) { [weak self] (response) in
        isSuccess = response.isSuccess
        count = response.value?.rows.count ?? 0
        self?.model = response.value!

        expect.fulfill()
        }
        XCTAssertTrue(isSuccess == true,
                      "MOCK SERVICE DATA NOT LOAD")
        XCTAssertTrue(count == 13,
                      "Record Count not right")
        wait(for: [expect], timeout: 3.0)

    }
    func testRealServerApi()
    {
        
        mockAPIService = MockService()
        
        let servicePath = JCPostServicePath.countryDetail
        var isSuccess = false
        var count = 0
        
        let client = CountryDetailApiClient()
        let resource = GenericResource(path: servicePath.path.rawValue, method:.GET)
        let expect = XCTestExpectation(description: "reload closure triggered")
        client.fetchCountryData(resource: resource) { [weak self] (response) in
            isSuccess = response.isSuccess
            count = response.value?.rows.count ?? 0
            self?.model = response.value!
            self?.sut.countryInfo = self?.model
            XCTAssertNotNil(self?.sut.successViewClosure)
            XCTAssertTrue(isSuccess == true,
                          "MOCK SERVICE DATA NOT LOAD")
            XCTAssertTrue(count > 0,
                          "Record Count not right")
            expect.fulfill()
        }
        
    }
    
    func testAlertMessage(){
       // sut.alertMessage
        XCTAssertEqual(sut.alertMessage, "Error")
    }

    func testModelObject(){
        XCTAssertNil(sut.countryInfo)
    }
    
    func testBasePathCorrect()
    {
        let servicePath = JCPostServicePath.countryDetail
        let resource = GenericResource(path: servicePath.path.rawValue, method:.GET)
        let endPoint = JCConfigEndPoints()
        XCTAssertEqual(resource.basePath, endPoint.appMode.baseEndPoint())
    }
    func testRecordContentFill()
    {
       testMockApi()
        XCTAssertNotNil(model)
         XCTAssertNotNil(model.rows)
        model.rows.forEach { (model) in
            let status = (model.description != nil || model.title != nil || model.imageHref != nil)
            print("check",status)
            XCTAssertTrue(status,"NULL record found")

            
        }
    }
}
