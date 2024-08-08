{...}: {
  programs.helix = {
    enable = true;
    settings = {
      theme = "custom";
      editor = {
        lsp.display-messages = true;
        scrolloff = 999;

        statusline = {
          left = [
            "mode"
            "spinner"
            "file-name"
            "read-only-indicator"
            "file-modification-indicator"
          ];
          right = [
            "diagnostics"
            "selections"
            "position"
            "file-encoding"
            "file-line-ending"
            "file-type"
          ];
          separator = "│";
          mode.normal = "N";
          mode.insert = "I";
          mode.select = "S";
        };
        cursor-shape = {
          insert = "bar";
          select = "underline";
        };
      };

      keys.normal = {
        space.space = "file_picker";
        esc = ["collapse_selection" "keep_primary_selection"];
      };
    };
    languages = {
      language = [
        {
          name = "nix";
          language-servers = ["nixd"];
          formatter = {command = "alejandra";};
        }
      ];
      language-server.nixd = {
        command = "nixd";
      };
    };
    themes = {
      custom = {
        "ui.background" = {fg = "white";};
        "ui.background.separator" = {fg = "gray";};
        "ui.text" = {fg = "light-gray";};
        "ui.text.focus" = {fg = "white";};
        "ui.menu" = {fg = "white";};
        "ui.menu.selected" = {modifiers = ["reversed"];};
        "ui.menu.scroll" = {fg = "light-gray";};
        "ui.linenr" = {fg = "gray";};
        "ui.linenr.selected" = {
          fg = "white";
          modifiers = ["bold"];
        };
        "ui.popup" = {fg = "white";};
        "ui.window" = {fg = "gray";};
        "ui.selection" = {bg = "gray";};
        "comment" = "gray";
        "ui.statusline" = {fg = "white";};
        "ui.statusline.inactive" = {fg = "gray";};
        "ui.statusline.normal" = {
          fg = "black";
          bg = "blue";
        };
        "ui.statusline.insert" = {
          fg = "black";
          bg = "green";
        };
        "ui.statusline.select" = {
          fg = "black";
          bg = "magenta";
        };
        "ui.help" = {fg = "light-gray";};
        "ui.cursor" = {
          bg = "light-gray";
          fg = "black";
        };
        "ui.cursor.match" = {
          fg = "yellow";
          underline = {
            color = "yellow";
            style = "line";
          };
        };
        "ui.cursor.primary" = {
          bg = "light-gray";
          fg = "black";
        };
        "ui.cursor.secondary" = {
          bg = "gray";
          fg = "black";
        };
        "ui.cursorline.primary" = {
          underline = {
            color = "light-gray";
            style = "line";
          };
        };
        "ui.cursorline.secondary" = {
          underline = {
            color = "light-gray";
            style = "line";
          };
        };
        "ui.cursorcolumn.primary" = {bg = "gray";};
        "ui.cursorcolumn.secondary" = {bg = "gray";};
        "ui.virtual.ruler" = {bg = "gray";};
        "ui.virtual.whitespace" = "gray";
        "ui.virtual.indent-guide" = "gray";
        "ui.virtual.inlay-hint" = {
          fg = "white";
          bg = "gray";
        };
        "ui.virtual.inlay-hint.parameter" = {
          fg = "white";
          bg = "gray";
        };
        "ui.virtual.inlay-hint.type" = {
          fg = "white";
          bg = "gray";
        };
        "ui.virtual.wrap" = "gray";
        "ui.virtual.jump-label" = {
          fg = "blue";
          modifiers = ["bold" "underlined"];
        };
        "variable" = "white";
        "constant" = "light-gray";
        "constant.numeric" = "yellow";
        "constant.character.escape" = "red";
        "string" = "yellow";
        "character" = "red";
        "number" = "red";
        "boolean" = "red";
        "float" = "red";
        "function" = "cyan";
        "type" = "magenta";
        "constructor" = "magenta";
        "special" = "blue";
        "keyword" = "light-gray";
        "label" = "blue";
        "namespace" = "magenta";
        "operator" = "light-gray";
        "punctuation" = "light-gray";
        "markup.link.url" = {
          fg = "cyan";
          underline = {
            color = "cyan";
            style = "line";
          };
        };
        "markup.heading" = "blue";
        "markup.list" = "red";
        "markup.bold" = {
          fg = "yellow";
          modifiers = ["bold"];
        };
        "markup.italic" = {
          fg = "magenta";
          modifiers = ["italic"];
        };
        "markup.strikethrough" = {modifiers = ["crossed_out"];};
        "markup.link.text" = "red";
        "markup.quote" = "cyan";
        "markup.raw" = "green";
        "markup.normal" = {fg = "blue";};
        "markup.insert" = {fg = "green";};
        "markup.select" = {fg = "magenta";};
        "diff.plus" = "green";
        "diff.delta" = "yellow";
        "diff.delta.moved" = "blue";
        "diff.minus" = "red";
        "ui.gutter" = "gray";
        "info" = "blue";
        "hint" = "gray";
        "debug" = "gray";
        "warning" = "yellow";
        "error" = "red";
        "diagnostic.info" = {
          underline = {
            color = "blue";
            style = "dotted";
          };
        };
        "diagnostic.hint" = {
          underline = {
            color = "gray";
            style = "double_line";
          };
        };
        "diagnostic.debug" = {
          underline = {
            color = "gray";
            style = "dashed";
          };
        };
        "diagnostic.warning" = {
          underline = {
            color = "yellow";
            style = "curl";
          };
        };
        "diagnostic.error" = {
          underline = {
            color = "red";
            style = "curl";
          };
        };
      };
    };
  };
}
