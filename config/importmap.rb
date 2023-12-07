# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "https://ga.jspm.io/npm:@hotwired/stimulus@3.2.2/dist/stimulus.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
pin_all_from "app/javascript/helpers", under: "helpers"
pin_all_from "app/javascript/controllers", under: "controllers"
pin "@rails/request.js", to: "https://ga.jspm.io/npm:@rails/request.js@0.0.9/src/index.js"
pin "@rails/activestorage", to: "https://ga.jspm.io/npm:@rails/activestorage@7.1.2/app/assets/javascripts/activestorage.esm.js"
pin "dropzone", to: "https://ga.jspm.io/npm:dropzone@6.0.0-beta.2/dist/dropzone.mjs"
pin "just-extend", to: "https://ga.jspm.io/npm:just-extend@5.1.1/index.esm.js"
pin "stimulus-textarea-autogrow", to: "https://ga.jspm.io/npm:stimulus-textarea-autogrow@4.1.0/dist/stimulus-textarea-autogrow.mjs"
pin "sortablejs", to: "https://ga.jspm.io/npm:sortablejs@1.15.1/modular/sortable.esm.js"
# MARKDOWN EDITOR
pin "easymde", to: "https://ga.jspm.io/npm:easymde@2.18.0/src/js/easymde.js"
pin "codemirror", to: "https://ga.jspm.io/npm:codemirror@5.65.14/lib/codemirror.js"
pin "codemirror-spell-checker", to: "https://ga.jspm.io/npm:codemirror-spell-checker@1.1.2/src/js/spell-checker.js"
pin "codemirror/", to: "https://ga.jspm.io/npm:codemirror@5.65.14/"
pin "fs", to: "https://ga.jspm.io/npm:@jspm/core@2.0.1/nodelibs/browser/fs.js"
pin "marked", to: "https://ga.jspm.io/npm:marked@4.3.0/lib/marked.cjs"
pin "typo-js", to: "https://ga.jspm.io/npm:typo-js@1.2.3/typo.js"
# END MARKDOWN EDITOR