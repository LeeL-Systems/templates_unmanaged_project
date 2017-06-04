
#include "./project_name.h"

using project_name::ProjectName;
using project_name::ProjectNameInterfacePtr;
using environment::EnvironmentInterfacePtr;

project_name::ProjectNameInterfacePtr CreateProjectName(EnvironmentInterfacePtr environment)
{
    return ProjectNameInterfacePtr(new ProjectName(environment));
}

ProjectName::ProjectName(EnvironmentInterfacePtr environment)
{
}

ProjectName::~ProjectName()
{
}
