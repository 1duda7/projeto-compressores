Análise e otimização de árvores de compressão (3:2, 6:3, 7:3 e 15:3) para FPGAs.
O projeto é organizado por estilo de descrição VHDL (`behavioral`, `arithmetic`, `logic`) para isolar as cadeias de dependência durante a síntese e simulação:
- `rtl/`: Módulos VHDL divididos por estilo e nível de hierarquia (`01_unit_cells`, `02_nbit_blocks`, `03_trees_15to2`, `04_trees_15to1`).
- `tb/`: Testbenches ordenados por hierarquia.
- `docs/`: Diagramas, relatórios de síntese (LUTs e delay).
- `sim/`: Scripts de simulação (GHDL/ModelSim).
- `synth/`: Arquivos de restrição (`.sdc`/`.xdc`).
