[Mesh]
  file = gold/rd02.e
[]

[GlobalParams]
  PorousFlowDictator = dictator
[]

[UserObjects]
  [./dictator]
    type = PorousFlowDictator
    porous_flow_vars = pressure
    number_fluid_phases = 1
    number_fluid_components = 1
  [../]
[]

[Materials]
  [./massfrac]
    type = PorousFlowMassFraction
  [../]
  [./temperature]
    type = PorousFlowTemperature
  [../]
  [./nnn]
    type = PorousFlowNodeNumber
    on_initial_only = true
  [../]
  [./dens0]
    type = PorousFlowDensityConstBulk
    density_P0 = 1E3
    bulk_modulus = 2E7
    phase = 0
  [../]
  [./dens_all]
    type = PorousFlowJoiner
    include_old = true
    material_property = PorousFlow_fluid_phase_density
  [../]
  [./dens_qp_all]
    type = PorousFlowJoiner
    material_property = PorousFlow_fluid_phase_density_qp
    at_qps = true
  [../]
  [./ppss]
    type = PorousFlow1PhaseP_VG
    porepressure = pressure
    m = 0.336
    al = 1.43E-4
  [../]
  [./relperm]
    type = PorousFlowRelativePermeabilityVG
    m = 0.336
    seff_turnover = 0.99
    phase = 0
  [../]
  [./relperm_all]
    type = PorousFlowJoiner
    material_property = PorousFlow_relative_permeability
  [../]
  [./porosity]
    type = PorousFlowPorosityConst
    porosity = 0.33
  [../]
  [./permeability]
    type = PorousFlowPermeabilityConst
    permeability = '0.295E-12 0 0  0 0.295E-12 0  0 0 0.295E-12'
  [../]
  [./visc0]
    type = PorousFlowViscosityConst
    viscosity = 1.01E-3
    phase = 0
  [../]
  [./visc_all]
    type = PorousFlowJoiner
    material_property = PorousFlow_viscosity
  [../]
[]



[Variables]
  [./pressure]
    initial_from_file_timestep = 1
    initial_from_file_var = pressure
  [../]
[]


[Kernels]
  [./mass0]
    type = PorousFlowMassTimeDerivative
    fluid_component = 0
    variable = pressure
  [../]
  [./flux0]
    type = PorousFlowAdvectiveFlux
    fluid_component = 0
    variable = pressure
    gravity = '-10 0 0'
  [../]
[]


[AuxVariables]
  [./SWater]
    family = MONOMIAL
    order = CONSTANT
  [../]
[]


[AuxKernels]
  [./SWater]
    type = MaterialStdVectorAux
    property = PorousFlow_saturation_qp
    index = 0
    variable = SWater
  [../]
[]


[BCs]
  [./base]
    type = DirichletBC
    boundary = left
    value = 0.0
    variable = pressure
  [../]
[]

[Preconditioning]
  [./andy]
    type = SMP
    full = true
    petsc_options = '-snes_converged_reason -ksp_diagonal_scale -ksp_diagonal_scale_fix -ksp_gmres_modifiedgramschmidt -snes_linesearch_monitor'
    petsc_options_iname = '-ksp_type -pc_type -sub_pc_type -sub_pc_factor_shift_type -pc_asm_overlap -snes_atol -snes_rtol -snes_max_it'
    petsc_options_value = 'gmres      asm      lu           NONZERO                   2               1E-10      1E-10      10'
  [../]
[]

[VectorPostprocessors]
  [./swater]
    type = LineValueSampler
    variable = SWater
    start_point = '0 0 0'
    end_point = '6 0 0'
    sort_by = x
    num_points = 121
    execute_on = timestep_end
  [../]
[]

[Executioner]
  type = Transient
  solve_type = Newton
  petsc_options = '-snes_converged_reason'
  end_time = 8.2944E6

  [./TimeStepper]
    type = FunctionDT
    time_dt = '2E4 1E6'
    time_t = '0 1E6'
  [../]
[]


[Outputs]
  file_base = rd03
  [./exodus]
    type = Exodus
    execute_on = final
  [../]
  [./along_line]
    type = CSV
    execute_on = final
  [../]
[]
