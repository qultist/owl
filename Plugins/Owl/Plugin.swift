import PackagePlugin

@main
struct OwlPlugin: BuildToolPlugin {

	func createBuildCommands(
		context: PackagePlugin.PluginContext,
		target: PackagePlugin.Target
	) async throws -> [PackagePlugin.Command] {
		print(target.name)

		return [
			.buildCommand(
				displayName: "Collecting package information",
				executable: try context.tool(named: "OwlExec").path,
				arguments: []
			)
		]
	}


}
