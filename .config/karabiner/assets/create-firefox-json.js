const fs = require("fs");
const { getAllKeyCodes } = require("./key-codes.js");
const { getManipulators } = require("./get-manipulators-for-ctrl-cmd-swap.js");

const conditions = [
  {
    bundle_identifiers: ["^org\\.mozilla\\.firefox$"],
    type: "frontmost_application_if"
  }
];

const keyCodes = getAllKeyCodes().filter(
  kc => kc !== "grave_accent_and_tilde" && kc !== "tab"
);

const manipulators = getManipulators(keyCodes, conditions);

const json = {
  title: "Firefox mods",
  rules: [
    {
      description: "In Firefox, swap Cmd and Ctrl (for most keys)",
      manipulators
    }
  ]
};

try {
  fs.writeFileSync("./complex_modifications/firefox.json", JSON.stringify(json));
} catch (err) {
  console.error(err);
}
