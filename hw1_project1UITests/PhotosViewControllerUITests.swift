import XCTest
@testable import hw1_project1

final class PhotosViewControllerUITests: XCTestCase {

    let app = XCUIApplication()

    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
    }

    func test_PhotosViewController_loadsPhotosAndPushesDetailVC() {
        let loginButton = app.buttons["Войти"]
        XCTAssertTrue(loginButton.waitForExistence(timeout: 5))
        loginButton.tap()

        let photosTab = app.tabBars.buttons["Photos"]
        XCTAssertTrue(photosTab.waitForExistence(timeout: 5))
        photosTab.tap()

        let collectionView = app.collectionViews.element(boundBy: 0)
        XCTAssertTrue(collectionView.waitForExistence(timeout: 5))

        let cell = collectionView.cells.element(boundBy: 0)
        XCTAssertTrue(cell.waitForExistence(timeout: 5))

        cell.tap()

        let imageView = app.images.element(boundBy: 0)
        XCTAssertTrue(imageView.waitForExistence(timeout: 5))
    }
}
