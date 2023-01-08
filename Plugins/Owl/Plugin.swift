import PackagePlugin

@main
struct OwlPlugin: BuildToolPlugin {

	func createBuildCommands(
		context: PackagePlugin.PluginContext,
		target: PackagePlugin.Target
	) async throws -> [PackagePlugin.Command] {
		fatalError("For now this plugin is meant to be used as Xcode build plugin.")
	}


}

#if canImport(XcodeProjectPlugin)
import Foundation
import XcodeProjectPlugin

extension OwlPlugin: XcodeBuildToolPlugin {

	func createBuildCommands(
		context: XcodeProjectPlugin.XcodePluginContext,
		target: XcodeProjectPlugin.XcodeTarget
	) throws -> [PackagePlugin.Command] {
		let licensesDirectoryPath = context.pluginWorkDirectory
			.appending(subpath: "Licenses")

		try? FileManager.default.removeItem(atPath: licensesDirectoryPath.string)

		try FileManager.default.createDirectory(
			atPath: licensesDirectoryPath.string,
			withIntermediateDirectories: false
		)

		return [
			.buildCommand(
				displayName: "Collecting package information",
				executable: try context.tool(named: "OwlExec").path,
				arguments: ["-o", licensesDirectoryPath],
				outputFiles: [licensesDirectoryPath]
			)
		]
	}
}
#endif
