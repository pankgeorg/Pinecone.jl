using Test
using Pinecone

GOODAPIKEY = ENV["PINECONE_API_KEY"]
CLOUDENV="us-west1-gcp"

@testset "PineconeIndex Type Tests" begin
   TESTINDEX = "test"
   pineconeindex = PineconeIndex(TESTINDEX)
   @test typeof(pineconeindex) == PineconeIndex
   @test pineconeindex.indexname == TESTINDEX
end;

@testset "PineconeContext Type Tests" begin
   KEY = "asdf-asdfadfs-adsfafds"
   ENV = "us.east.gcp"
   PROJECT = "testproject"
   pineconecontext = PineconeContext(KEY, ENV, PROJECT)
   @test typeof(pineconecontext) == PineconeContext
   @test pineconecontext.apikey == KEY
   @test pineconecontext.cloudenvironment == ENV
   @test pineconecontext.projectname == PROJECT
end

@testset "PineconeVector Type Tests" begin
   VID = "vectorid"
   VALUES = [0.1, 0.2, 0.3, 0.4]
   META = Dict{String, Any}("foo"=>"bar", "key"=>"value", "numeric"=>1234)
   pineconevector = PineconeVector(VID, VALUES, META)
   @test typeof(pineconevector) == PineconeVector
   @test pineconevector.id == VID
   @test length(pineconevector.values) == 4
   @test typeof(pineconevector.values) == Vector{Float64}
   @test length(pineconevector.metadata) == 3
   @test typeof(pineconevector.metadata) == Dict{String,Any}
end

@testset "Test Init" begin
   #make a bogus init() call, should return nothing
   BADAPIKEY = "zzzz123456"
   context = Pinecone.init(BADAPIKEY, "badcloud")

   @test context == nothing

   #now check for proper setup
   goodcontext = Pinecone.init(GOODAPIKEY, CLOUDENV)
   @test goodcontext != nothing
   @test typeof(goodcontext) == PineconeContext
end

@testset "Test whoami()" begin
   context = Pinecone.init(GOODAPIKEY, CLOUDENV)
   result = Pinecone.whoami(context)
   @test result !== nothing
   @test typeof(result) == String
end

@testset "Test list_indexes()" begin
   context = Pinecone.init(GOODAPIKEY, CLOUDENV)
   result = Pinecone.list_indexes(context)
   @test result !== nothing
   @test typeof(result) == String
end