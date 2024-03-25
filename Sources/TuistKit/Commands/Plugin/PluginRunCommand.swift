import ArgumentParser
import Foundation
import TSCBasic
import TuistSupport

public struct PluginRunCommand: ContextualizedAsyncParsableCommand {
    public init() {}

    public static var configuration: CommandConfiguration {
        CommandConfiguration(
            commandName: "run",
            abstract: "Runs a plugin."
        )
    }

    @OptionGroup()
    var pluginOptions: PluginCommand.PluginOptions

    @Flag(
        help: "Build both source and test targets."
    )
    var buildTests = false

    @Flag(
        help: "Skip building the plugin."
    )
    var skipBuild = false

    @Argument(
        help: "The plugin task to run."
    )
    var task: String

    @Argument(
        help: "The arguments to pass to the plugin task."
    )
    var arguments: [String] = []

    public func run() async throws {
        try await run(context: TuistContext())
    }

    public func run(context _: Context) async throws {
        try PluginRunService().run(
            path: pluginOptions.path,
            configuration: pluginOptions.configuration,
            buildTests: buildTests,
            skipBuild: skipBuild,
            task: task,
            arguments: arguments
        )
    }
}
