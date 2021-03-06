
init8500()


@testset "PDElements" begin 

@test PDElements.Count() == 4904
@test PDElements.First() == 1
@test PDElements.Next() == 1
@test PDElements.IsShunt() == 0
@test PDElements.NumCustomers() == 0
@test PDElements.TotalCustomers() == 0
# @test PDElements.ParentPDElement()      # ERROR
@test PDElements.FromTerminal() == 1
@test PDElements.SectionID() == 0
@test PDElements.FaultRate() ≋ 0.1
@test PDElements.FaultRate(PDElements.FaultRate()) ≋ 0.0
@test PDElements.PctPermanent() ≋ 20.0
@test PDElements.PctPermanent(PDElements.PctPermanent()) ≋ 0.0
@test PDElements.Lambda() ≋ 0.0
@test PDElements.AccumulatedL() ≋ 0.0
@test PDElements.RepairTime() ≋ 3.0
@test PDElements.TotalMiles() ≋ 0.0
@test PDElements.Name() == "Line.ln5502549-1" 
@test PDElements.Name(PDElements.Name()) == "0"

end # testset

