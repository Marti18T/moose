/****************************************************************/
/*               DO NOT MODIFY THIS HEADER                      */
/* MOOSE - Multiphysics Object Oriented Simulation Environment  */
/*                                                              */
/*           (c) 2010 Battelle Energy Alliance, LLC             */
/*                   ALL RIGHTS RESERVED                        */
/*                                                              */
/*          Prepared by Battelle Energy Alliance, LLC           */
/*            Under Contract No. DE-AC07-05ID14517              */
/*            With the U. S. Department of Energy               */
/*                                                              */
/*            See COPYRIGHT for full restrictions               */
/****************************************************************/

#include "AddDiracKernelAction.h"
#include "FEProblem.h"

template<>
InputParameters validParams<AddDiracKernelAction>()
{
  InputParameters params = validParams<MooseObjectAction>();
  return params;
}

AddDiracKernelAction::AddDiracKernelAction(InputParameters params) :
    MooseObjectAction(params)
{
}

void
AddDiracKernelAction::act()
{
  _problem->addDiracKernel(_type, _name, _moose_object_pars);
}
