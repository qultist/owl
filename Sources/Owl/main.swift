import ArgumentParser
import Foundation

struct Owl: ParsableCommand {

	@Option(name: .shortAndLong, help: "The Xcode build directory.")
	var buildDir: String

	@Option(name: .shortAndLong, help: "The output directory where the found licenses etc. are copied to.")
	var outputDir: String

	func run() throws {
		guard
			let encodedBuildDir = buildDir.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed),
			let buildDirUrl = URL(string: encodedBuildDir),
			let buildIndex = buildDirUrl.pathComponents.firstIndex(of: "Build")
		else {
			return
		}

		var derivedDataUrl = URL(string: "file://")!
		for component in buildDirUrl.pathComponents[..<buildIndex] {
			derivedDataUrl.appendPathComponent(component)
		}

		let workspaceStateUrl = derivedDataUrl.appendingPathComponent("SourcePackages/workspace-state.json")

		guard
			let workspaceStateData = try? Data(contentsOf: workspaceStateUrl)
		else {
			print("Could not find workspace-state.json")
			return
		}

		var workspaceState: WorkspaceState!

		do {
			workspaceState = try JSONDecoder().decode(WorkspaceState.self, from: workspaceStateData)
		} catch (let error) {
			print("Could not decode workspace state. Error: \(error)")
			return
		}

		let checkoutsUrl = derivedDataUrl.appendingPathComponent("SourcePackages/checkouts")
		let outputUrl = URL(string: "file://" +  outputDir)!
		let fm = FileManager.default

		var packages = [SwiftPackage]()

		for dependency in workspaceState.object.dependencies {
			let dependencyUrl =  checkoutsUrl.appendingPathComponent(dependency.subpath)
			let licenseUrl = dependencyUrl.appendingPathComponent("LICENSE")
			let noticeUrl = dependencyUrl.appendingPathComponent("NOTICE")
			let licenseCopyUrl = outputUrl.appendingPathComponent("\(dependency.packageRef.identity)-license")
			let noticeCopyUrl = outputUrl.appendingPathComponent("\(dependency.packageRef.identity)-notice")

			if fm.fileExists(atPath: licenseUrl.path) {
				try copyFile(at: licenseUrl, to: licenseCopyUrl)
			} else if fm.fileExists(atPath: licenseUrl.appendingPathExtension("txt").path) {
				try copyFile(at: licenseUrl.appendingPathExtension("txt"), to: licenseCopyUrl)
			} else if fm.fileExists(atPath: licenseUrl.appendingPathExtension("md").path) {
				try copyFile(at: licenseUrl.appendingPathExtension("md"), to: licenseCopyUrl)
			}

			if fm.fileExists(atPath: noticeUrl.path) {
				try copyFile(at: noticeUrl, to: noticeCopyUrl)
			} else if fm.fileExists(atPath: noticeUrl.appendingPathExtension("txt").path) {
				try copyFile(at: noticeUrl.appendingPathExtension("txt"), to: noticeCopyUrl)
			} else if fm.fileExists(atPath: noticeUrl.appendingPathExtension("md").path) {
				try copyFile(at: noticeUrl.appendingPathExtension("md"), to: noticeCopyUrl)
			}

			let package = SwiftPackage(from: dependency)
			packages.append(package)

			if fm.fileExists(atPath: licenseCopyUrl.path) {
				package.licenseFile = "\(dependency.packageRef.identity)-license"
			}

			if fm.fileExists(atPath: noticeCopyUrl.path) {
				package.noticeFile = "\(dependency.packageRef.identity)-notice"
			}
		}

		let packagesJsonData = try JSONEncoder().encode(packages.sorted { $0.name < $1.name })

		try String(data: packagesJsonData, encoding: .utf8)?
			.write(to: outputUrl.appendingPathComponent("packages.json"), atomically: true, encoding: .utf8)

	}

	private func copyFile(at srcUrl: URL, to destUrl: URL) throws {
		try? FileManager.default.removeItem(at: destUrl)
		try FileManager.default.copyItem(at: srcUrl, to: destUrl)
	}
}

Owl.main()
