#ifndef %include-guard%
#define %include-guard%

#include <iosfwd>

%namespace-open%

class %file-without-ext% {
public:
    /// Default constructor
    %file-without-ext%();
    /// Destructor
    ~%file-without-ext%();
    /// Copy constructor
    %file-without-ext%(const %file-without-ext%& rhs);
    /// Assignment operator
    %file-without-ext%& operator=(const %file-without-ext%& rhs);
};

/// stream output operator
std::ostream& operator<<(std::ostream& lhs, const %file-without-ext%& rhs);

%namespace-close%
#endif /* %include-guard% */
