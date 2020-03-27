const fs = require("fs");
const { key_codes } = require("./key-codes.js");

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

const type = "basic";

const manipulators = [];
key_codes.forEach(key_code => {
  [
    ["command", "control"],
    ["control", "command"]
  ].forEach(([mod1, mod2]) => {
    manipulators.push({
      conditions,
      type,
      from: {
        key_code,
        modifiers: {
          mandatory: [mod1],
          optional: ["any"]
        }
      },
      to: [
        {
          key_code,
          modifiers: [mod2]
        }
      ]
    });
  });
});

const json = {
  title: "Terminal mods",
  rules: [
    {
      description:
        "In terminal emulators, swap Cmd and Ctrl (for most keys)",
      manipulators
    }
  ]
};

try {
  fs.writeFileSync("./complex_modifications/terms.json", JSON.stringify(json));
} catch (err) {
  console.error(err);
}
