# jQuery = require 'jQuery'
module.exports =

  activate: (state) ->
    php = atom.packages.loadPackage('language-php')
    php.activate().done(@.doit)
  doit: ->
    if not atom.config.get('drupal.fileTypesPhp')
      defaults = "module,install,inc,test,profile"
      atom.config.set('drupal.fileTypesPhp', defaults)
    typeString = atom.config.get('drupal.fileTypesPhp')
    typeList = typeString.split(",")
    phpGrammar = atom.packages.getLoadedPackage('language-php').grammars[0]
    phpGrammar.fileTypes = phpGrammar.fileTypes.concat(typeList)
    phpGrammar.activate()
