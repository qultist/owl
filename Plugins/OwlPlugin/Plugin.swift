import PackagePlugin

struct OwlPlugin: BuildToolPlugin {

	func createBuildCommands(
		context: PackagePlugin.PluginContext,
		target: PackagePlugin.Target
	) async throws -> [PackagePlugin.Command] {
		print(target.name)

		return [
			.buildCommand(
				displayName: "Collecting…",
				executable: try context.tool(named: "Owl").path,
				arguments: []
			)
		]
	}


}
