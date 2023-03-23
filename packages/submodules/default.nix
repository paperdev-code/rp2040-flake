{ callPackage }:
let
  submodule = module: (callPackage "${module}" { });
in
{
  btstack = submodule ./btstack.nix;
}
