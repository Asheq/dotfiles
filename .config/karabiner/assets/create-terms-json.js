const fs = require("fs");
const { getAllKeyCodes } = require("./key-codes.js");
const { getManipulators } = require("./get-manipulators-for-ctrl-cmd-swap.js");

const conditions = [
  {
    file_paths: ["/Applications/neovide"],
    bundle_identifiers: [
      "^org\\.vim\\.MacVim$",
      "^net\\.kovidgoyal\\.kitty$",
      "^io\\.alacritty$",
      "^com\\.qvacua\\.VimR$",
      "^com\\.outrunlabs\\.onivim2$",
      "^com\\.ident\\.gonvim$",
      "^com\\.ident\\.goneovim$"
    ],
    type: "frontmost_application_if"
  }
];

const keyCodes = getAllKeyCodes().filter(
  kc => kc !== "grave_accent_and_tilde" && kc !== "tab" && kc !== "spacebar"
);

const manipulators = getManipulators(keyCodes, conditions);

const json = {
  title: "Terminal mods",
  rules: [
    {
      description: "In terminal emulators, swap Cmd and Ctrl (for most keys)",
      manipulators
    }
  ]
};

try {
  fs.writeFileSync("./complex_modifications/terms.json", JSON.stringify(json));
} catch (err) {
  console.error(err);
}
