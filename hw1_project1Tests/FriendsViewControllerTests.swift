import XCTest
@testable import hw1_project1

final class FriendsViewControllerTests: XCTestCase {

    var networkService: NetworkServiceTests!
    var fileCache: FileCacheTests!
    var sut: FriendsViewController!

    override func setUp() {
        super.setUp()
        networkService = NetworkServiceTests()
        fileCache = FileCacheTests()
        sut = FriendsViewController(networkService: networkService, fileCache: fileCache)
        _ = sut.view
    }

    override func tearDown() {
        sut = nil
        networkService = nil
        fileCache = nil
        super.tearDown()
    }

    func test_viewDidLoad_fetchesFriendsFromCache() {
        fileCache.friendsToReturn = [Friend(id: 1, firstName: "Test", lastName: "User", photo100: "", online: 1)]
        sut.viewDidLoad()
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 1)
    }

    func test_getFriends_success_updatesModelsAndCache() {
        let friends = [Friend(id: 2, firstName: "John", lastName: "Smith", photo100: "", online: 1)]
        networkService.resultToReturn = .success(friends)

        let expect = expectation(description: "Reload data called")

        sut.getFriends()

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            XCTAssertEqual(self.sut.tableView.numberOfRows(inSection: 0), 1)
            XCTAssertTrue(self.fileCache.addFriendsCalled)
            expect.fulfill()
        }

        wait(for: [expect], timeout: 1.0)
    }

    func test_getFriends_failure_fetchesFromCacheAndShowsAlert() {
        networkService.resultToReturn = .failure(NSError(domain: "", code: 0))
        fileCache.friendsToReturn = [Friend(id: 3, firstName: "Cached", lastName: "Friend", photo100: "", online: 0)]

        let expect = expectation(description: "Alert presented")

        sut.presentAlertHandler = { (alert: UIAlertController) in
            XCTAssertEqual(alert.title, "Не удалось получить данные")
            expect.fulfill()
        }

        DispatchQueue.main.async {
            self.sut.getFriends()
        }

        wait(for: [expect], timeout: 1)
    }

    func test_tableView_didSelectRow_pushesProfileViewController() {
        let navController = UINavigationController(rootViewController: sut)
        sut.models = [Friend(id: 5, firstName: "Friend", lastName: "Test", photo100: "", online: 0)]

        sut.tableView(sut.tableView, didSelectRowAt: IndexPath(row: 0, section: 0))

        let pushedVC = navController.topViewController
        XCTAssertTrue(pushedVC is ProfileViewController)
    }

    func test_tableView_cellForRow_updatesCell() {
        sut.models = [Friend(id: 7, firstName: "Cell", lastName: "Test", photo100: "", online: 1)]
        sut.tableView.register(CustomFriendViewCell.self, forCellReuseIdentifier: "FriendCell")

        let cell = sut.tableView(sut.tableView, cellForRowAt: IndexPath(row: 0, section: 0))
        XCTAssertTrue(cell is CustomFriendViewCell)
    }
}
