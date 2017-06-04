
#ifndef LEEL_TEMPLATES_SRC_PROJECT_NAME_H_
#define LEEL_TEMPLATES_SRC_PROJECT_NAME_H_

#include "../include/project_name_interfaces.h"

namespace project_name
{
    class ProjectName : public ProjectNameInterface
    {
    public:
        ProjectName(environment::EnvironmentInterfacePtr environment);
        ~ProjectName();

    private:
        environment::EnvironmentInterfacePtr _environment;
    };

}  // namespace project_name

#endif  // LEEL_TEMPLATES_SRC_PROJECT_NAME_H_
