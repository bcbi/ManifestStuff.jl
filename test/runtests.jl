using ManifestUtilities
using Test

@testset "manifest_format_1_0" begin
    format_dir = joinpath(@__DIR__, "manifest_format_1_0")
    @testset "test_1" begin
        test_dir = joinpath(format_dir, "test_1")
        project_filename = joinpath(test_dir, "Project_in.toml")
        manifest_filename = joinpath(test_dir, "Manifest_in.toml")
        joinpath(test_dir, "Manifest_out_correct.toml")
        joinpath(test_dir, "Manifest_out_incorrect.toml")
        x_1_a = prune_manifest(; project_filename, manifest_filename)
        x_1_b = sprint(io -> prune_manifest(io; project_filename, manifest_filename))
        @test strip(x_1_a) == strip(x_1_b)
        x_2 = read(joinpath(test_dir, "Manifest_out_correct.toml"), String)
        x_3 = read(joinpath(test_dir, "Manifest_out_incorrect.toml"), String)
        for x_1 in [x_1_a, x_1_b]
            @test strip(x_1) == strip(x_2)
            @test strip(x_2) != strip(x_3)
        end
    end
end
