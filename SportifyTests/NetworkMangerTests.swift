//
//  NetworkMangerTests.swift
//  SportifyTests
//
//  Created by Macos on 20/05/2025.
//
import XCTest
import Alamofire
@testable import Sportify

class NetworkMangerTests: XCTestCase {

    struct DummyResult: Decodable, Equatable {
        let title: String
    }

    class MockRequester: NetworkRequestPerforming {
        var capturedURL: String?
        var capturedParams: Parameters?
        var shouldReturnError = false

        func request<T>(
            _ url: String,
            parameters: Parameters,
            completion: @escaping (Result<T, Error>) -> Void
        ) where T : Decodable {
            self.capturedURL = url
            self.capturedParams = parameters

            if shouldReturnError {
                completion(.failure(NSError(domain: "", code: 500, userInfo: nil)))
            } else {
                let dummy = ApiResponse(success: 1, result: DummyResult(title: "Test") as! T)
                completion(.success(dummy.result))
            }
        }
    }

    func testFetchLeaguesSuccess() {
        let mock = MockRequester()
        let networkManager = NetworkManger(requester: mock)

        let expectation = self.expectation(description: "Fetch leagues")

        networkManager.fetchData(sport: "football", requestType: "Leagues") { (result: Result<DummyResult, Error>) in
            switch result {
            case .success(let res):
                XCTAssertEqual(res.title, "Test")
            case .failure:
                XCTFail("Expected success")
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1)

        XCTAssertEqual(mock.capturedURL, "https://apiv2.allsportsapi.com/football/")
        XCTAssertEqual(mock.capturedParams?["met"] as? String, "Leagues")
    }

    func testFetchLeaguesFailure() {
        let mock = MockRequester()
        mock.shouldReturnError = true
        let networkManager = NetworkManger(requester: mock)

        let expectation = self.expectation(description: "Fetch leagues failure")

        networkManager.fetchData(sport: "football", requestType: "Leagues") { (result: Result<DummyResult, Error>) in
            switch result {
            case .success:
                XCTFail("Expected failure")
            case .failure(let error):
                XCTAssertNotNil(error)
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1)
    }
    func testFetchData_Leagues() {
        let expectation = XCTestExpectation(description: "Leagues fetch")
        
        NetworkManger.shared.fetchData(
            sport: "football",
            requestType: "Leagues"
        ) { (result: Result<[LeagueDto], Error>) in
            // mock your League model accordingly
            switch result {
            case .success(let leagues):
                XCTAssertNotNil(leagues)
            case .failure(let error):
                XCTFail("Error: \(error)")
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 3)
    }
    func testFetchData_Fixtures() {
        let expectation = XCTestExpectation(description: "Fixtures fetch")
        
        NetworkManger.shared.fetchData(
            sport: "football",
            requestType: "Fixtures"
        ) { (result: Result<[FixtureDto], Error>) in
            
            switch result {
            case .success(let fixtures):
                XCTAssertNotNil(fixtures)
            case .failure(let error):
                XCTFail("Error: \(error)")
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 3)
    }
    func testFetchData_TeamDetails() {
        let expectation = XCTestExpectation(description: "Fixtures fetch")
        
        NetworkManger.shared.fetchData(
            sport: "football",
            requestType: "Teams"
        ) { (result: Result<[TeamDetailDto], Error>) in
            
            switch result {
            case .success(let teams):
                XCTAssertNotNil(teams)
            case .failure(let error):
                XCTFail("Error: \(error)")
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 3)
    }

}

