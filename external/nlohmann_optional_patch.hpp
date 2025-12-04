#ifndef NLOHMANN_OPTIONAL_HELPER
#define NLOHMANN_OPTIONAL_HELPER

#include <optional>
#include <nlohmann/json.hpp>

namespace nlohmann {
    template <typename T>
    struct adl_serializer<std::optional<T>> {
        static void from_json(const json& j, std::optional<T>& opt) {
            if (j.is_null()) { opt = std::nullopt; } else { opt = j.get<T>(); }
        }
    };
}

#endif
