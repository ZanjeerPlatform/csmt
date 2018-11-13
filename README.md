# CSMT

CSMT package implements the [**Compact Sparse Merkle tree**](https://osf.io/8mcnh/download) whitepaper. It is used inside [**Bargad Framework**](https://github.com/ZanjeerPlatform/bargad) for its Verifiable Map mode of operation.

EthResearch discussion
https://ethresear.ch/t/compact-sparse-merkle-trees/3741

CSMT
https://eprint.iacr.org/2018/955.pdf

## Installation

The package can be installed by adding `csmt` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:csmt, "~> 1.0"}
  ]
end
```

The docs can be found at [https://hexdocs.pm/csmt](https://hexdocs.pm/csmt).
