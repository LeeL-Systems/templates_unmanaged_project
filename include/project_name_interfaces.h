
#ifndef LEEL_TEMPLATES_INCLUDE_PROJECT_NAME_INTERFACES_H_
#define LEEL_TEMPLATES_INCLUDE_PROJECT_NAME_INTERFACES_H_

#include <environment/environment.hpp>

namespace project_name
{
    class ProjectNameInterface
    {
    public:
        ~ProjectNameInterface();
    };

    typedef shared_ptr<ProjectNameInterface> ProjectNameInterfacePtr;

    ProjectNameInterfacePtr CreateProjectName(environment::EnvironmentInterfacePtr environment);

}  // namespace project_name

#endif  // LEEL_TEMPLATES_INCLUDE_PROJECT_NAME_INTERFACES_H_
