defmodule CSMTTest do
  use ExUnit.Case

  @k0 <<0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0>>

  @k1 <<0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1>>

  @k2 <<0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2>>

  @k3 <<0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3>>

  @k4 <<0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4>>
  
  @k5 <<0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5>>
  
  @k6 <<0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6>>
  
  @k7 <<0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7>>
  
  @k8 <<0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8>>

  @k10 <<0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10>>

  @k63 <<0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 63>>

  @k254 <<0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 254>>  
  


  test "create a new csmt, insert key value pairs" do
    csmt = CSMT.new("test", :sha256, [{"module", "ETSBackend"}])
           |> CSMT.insert(@k1, "1")
           |> CSMT.insert(@k7, "7")
           |> CSMT.insert(@k6, "6")
           |> CSMT.insert(@k2, "2")

    assert CSMT.audit_tree(csmt) == [{"L", "L", "1"}, {"L", "R", "2"}, {"R", "L", "6"}, {"R", "R", "7"}]
  end

  test "get with inclusion proof for a csmt" do

    csmt = CSMT.new("test", :sha256, [{"module", "ETSBackend"}])
           |> CSMT.insert(@k1, "1")
           |> CSMT.insert(@k7, "7")
           |> CSMT.insert(@k6, "6")
           |> CSMT.insert(@k2, "2")
           
    assert CSMT.get_with_inclusion_proof(csmt, @k2) == %{key: @k2, proof: [{CSMT.Utils.make_hash(csmt, CSMT.Utils.salt_node(@k1, "1")), "L"}, { CSMT.Utils.make_hash(csmt, CSMT.Utils.make_hash(csmt, CSMT.Utils.salt_node(@k6, "6")) <> CSMT.Utils.make_hash(csmt, CSMT.Utils.salt_node(@k7, "7"))) , "R"}], value: "2", hash: CSMT.Utils.make_hash(csmt, CSMT.Utils.salt_node(@k2, "2"))} 
  end

  test "non-inclusion proof for a csmt" do

    csmt = CSMT.new("test", :sha256, [{"module", "ETSBackend"}])
           |> CSMT.insert(@k1, "1")
           |> CSMT.insert(@k7, "7")
           |> CSMT.insert(@k6, "6")
           |> CSMT.insert(@k2, "2")
    
        
    assert CSMT.get_with_inclusion_proof(csmt, @k0) == 
    [ nil, %{key: @k1, proof: [{CSMT.Utils.make_hash(csmt, CSMT.Utils.salt_node(@k2, "2")), "R"}, { CSMT.Utils.make_hash(csmt, CSMT.Utils.make_hash(csmt, CSMT.Utils.salt_node(@k6, "6")) <> CSMT.Utils.make_hash(csmt, CSMT.Utils.salt_node(@k7, "7"))) , "R"}], value: "1", hash: CSMT.Utils.make_hash(csmt, CSMT.Utils.salt_node(@k1, "1"))}]
           
    
    assert CSMT.get_with_inclusion_proof(csmt, @k2) == %{key: @k2, proof: [{CSMT.Utils.make_hash(csmt, CSMT.Utils.salt_node(@k1, "1")), "L"}, { CSMT.Utils.make_hash(csmt, CSMT.Utils.make_hash(csmt, CSMT.Utils.salt_node(@k6, "6")) <> CSMT.Utils.make_hash(csmt, CSMT.Utils.salt_node(@k7, "7"))) , "R"}], value: "2", hash: CSMT.Utils.make_hash(csmt, CSMT.Utils.salt_node(@k2, "2"))} 
  end


  test "delete values from a csmt" do
    csmt = CSMT.new("test", :sha256, [{"module", "ETSBackend"}])
           |> CSMT.insert(@k1, "1")
           |> CSMT.insert(@k7, "7")
           |> CSMT.insert(@k6, "6")
           |> CSMT.insert(@k2, "2")

    csmt = CSMT.delete!(csmt, @k2)

    assert CSMT.audit_tree(csmt) == [{"L", "1"}, {"R", "L", "6"}, {"R", "R", "7"}] 
  end


end
