`timescale 1ns / 1ps
//-----------------------------------------------
module or_gate
(
  input [9:0] i,
  output o
);
//-----------------------------------------------
wire [4095:0]data=4096'hf5ffe6ecf6c7fd7c7577ec5e5f46e55ef474ee66444ff77d756475fde5d76f6fd7ced54c7f67476cdf5fed477ff4644fdf4eee4e476f776665e4fefd7ee5f4f5def75ce5fe4d75ffcc7f47ffcfcffde657cd5475dfc566f66d7cdc675cd655cdf46fd476f7cdddd7fe4dd7e4f545d4c467ee457c5f654664cc6f4567fc6e77fcc6e7cfff4ee6f74eedfdf7e54dee5c7e77fcdeecf6545d44dce676f4cf4fd7ed647f544edeedecdde46ec44d7ed77dfeddc564d657dece675ddf565f7fde7d4dc6c47ec5544f75fdfd5de7f57c466f67e6f5cc5cfd4647777676c46d5fed6d67574f6fecee75dee7d54eee6dce74eedcff6dd5cfd4674ffc4447d6cc5fccee4666f46df547e7e6d67e6f5f457e45ed45ddce565c5656754c5e546e5464d664fddfe5f5efecdf5eee45447f7f4fdcf5e4dd677cd4fef7ce6ce6c6ff4f5f4544ed575feffc675cc6edecee47dc64776d4e5e57644dd75ef4eefc47e5d6465c5cecdf4c4d74cf4ddf6f5d6465cfdc56c4c1cc7f7ec46c5dfd596ec57755e4de6ee9dc5d46df4ff67f54c77de546445f4f7d7de7c746e7c7d677775dde6e457c7e6dd4f6e7ef67ccf6e55e454f45fdf7ef686d4e4d4657d54f79ed5f5e5d7c6e6743efcdc5ceecc7ed7d577d6fd4f74ecd6ef6de5e67e4df4cfc447d56ded46c75f7cdff74f746476de544de74cfedee6550f45e56ec7f75dcda4f647defdf6ee4d9;
//-----------------------------------------------
assign o = data[4*i+2];
//-----------------------------------------------
endmodule
//-----------------------------------------------