#' Check Julia setup
#'
#' Checks that Julia (v1.0.0+) can be started and install  ANOVADDPTest.jl.
#' For more information about the setup and discovery of Julia, see
#' the JuliaConnectoR's package documentation, section "Setup".
#' @importFrom JuliaConnectoR juliaEval
#' @export
setup <- function() {
  message("Checking that Julia (version >= 1.0) can be started...")
  if (!JuliaConnectoR::juliaSetupOk()) {
    stop("Julia could not be started.")
  }

  message("Installing ANOVADDPTest.jl...")
  suppressMessages(juliaEval('
    import Pkg;
    url = "https://github.com/igutierrezm/ANOVADDPTest.jl"
    Pkg.add(url = url; io=devnull);
  '))
}

