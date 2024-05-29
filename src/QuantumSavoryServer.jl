using Oxygen
using HTTP
using TOML: parsefile
using YAML: load_file
using Bonito
using WGLMakie

WGLMakie.activate!()

include("Constants.jl")
include("URL.jl")
include("Model.jl")
include("Service.jl")
include("Controller.jl")
include("Plot.jl")

# swagger config
info = Dict("title" => "QuantumSavoryServer", "version" => "1.0.0")
openApi = OpenAPI("3.0", info)
swagger_document = build(openApi)
mergeschema(swagger_document)

# swagger_defs = load_file("src/Swagger.yaml")
# mergeschema(swagger_defs)

# server config
config = parsefile(SERVER_CONFIG_PATH)

# Define the network
reg_net = RegisterNet([Register(3), Register(4), Register(3)])

# Define the figure
f = Figure()
_, _, plot, obs = registernetplot_axis(f[1,1], reg_net)

# Starting point for the Quantum Savory Server
serve(host=config[SERVER][HOST], port=config[SERVER][PORT])  


