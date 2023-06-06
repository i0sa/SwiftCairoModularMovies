import XCTest
@testable import ConsumerNetworking

func XCTAssertResultSuccess<T, E>(_ result: Result<T, E>?,
                                  then assertions: (T) -> Void = { _ in },
                                  message: (E) -> String = { "Expected to be a success but got a failure with \($0)" },
                                  file: StaticString = #filePath,
                                  line: UInt = #line) where E: Error {
    switch result {
    case .success(let value):
        assertions(value)
    case .failure(let error):
        XCTFail(message(error), file: file, line: line)
    case nil:
        XCTFail("Expected to be a success but got a nil value", file: file, line: line)
    }
}

func XCTAssertResultFailure<T, E>(_ result: Result<T, E>?,
                                  then assertions: (E) -> Void = { _ in },
                                  message: (T) -> String = { "Expected to be a failure but got a success with \($0)" },
                                  file: StaticString = #filePath,
                                  line: UInt = #line) where E: Error {
    switch result {
    case .success(let value):
        XCTFail(message(value), file: file, line: line)
    case .failure(let error):
        assertions(error)
    case nil:
        XCTFail("Expected to be a failure but got a nil value", file: file, line: line)
    }
}
