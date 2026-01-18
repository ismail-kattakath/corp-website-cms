import { useEffect, useState } from "react";

const useTheme = (): string => {
  const [themeValue, setThemeValue] = useState("light");

  useEffect(() => {
    // Lite theme always returns "light"
    setThemeValue("light");
  }, []);

  return themeValue;
};

export default useTheme;
