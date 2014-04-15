
#include %include%
#include <ostream>

%namespace-open%

/**
 * Default constructor
 */
%file-without-ext%::%file-without-ext%() {
}

/**
 * Default destructor
 */
%file-without-ext%::~%file-without-ext%() {
}

/**
 * Copy constructor
 */
%file-without-ext%::%file-without-ext%(const %file-without-ext%& rhs) {
}

/**
 * Assignment operator
 */
%file-without-ext%& %file-without-ext%::operator=(const %file-without-ext%& rhs) {
    if (this != &rhs) {
        // TODO: implement copy
    }
    return *this;
}

/**
 * stream output operator
 */
std::ostream& operator<<(std::ostream& lhs, const %file-without-ext%& rhs) {
    lhs << "%namespace%::%file-without-ext%{" <<
        // TODO: implement out stream of member data
        "}";
    return lhs;
}
%namespace-close%
