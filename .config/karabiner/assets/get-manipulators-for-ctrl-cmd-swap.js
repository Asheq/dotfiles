exports.getManipulators = (keyCodes, conditions) => {
  const manipulators = [];

  keyCodes.forEach(keyCode => {
    [
      ["command", "control"],
      ["control", "command"]
    ].forEach(([mod1, mod2]) => {
      manipulators.push({
        conditions,
        type: "basic",
        from: {
          key_code: keyCode,
          modifiers: {
            mandatory: [mod1],
            optional: ["any"]
          }
        },
        to: [
          {
            key_code: keyCode,
            modifiers: [mod2]
          }
        ]
      });
    });
  });

  return manipulators;
};
