{
  description = ''Useful utilities for manipulating and visualizing byte blobs'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs."byteutils-master".dir   = "master";
  inputs."byteutils-master".owner = "nim-nix-pkgs";
  inputs."byteutils-master".ref   = "master";
  inputs."byteutils-master".repo  = "byteutils";
  inputs."byteutils-master".type  = "github";
  inputs."byteutils-master".inputs.nixpkgs.follows = "nixpkgs";
  inputs."byteutils-master".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@inputs:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib"];
  in lib.mkProjectOutput {
    inherit self nixpkgs;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
    refs = builtins.removeAttrs inputs args;
  };
}