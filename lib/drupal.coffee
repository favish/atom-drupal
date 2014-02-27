module.exports =

  activate: (state) ->
    if not atom.config.get('drupal.fileTypesPhp')
      defaults = "module,install,inc,test"
      atom.config.set('drupal.fileTypesPhp', defaults)

    typeString = atom.config.get('drupal.fileTypesPhp')
    typeList = typeString.split(",")
    phpGrammar = atom.packages.getLoadedPackage('language-php').grammars[0]
    phpGrammar.fileTypes = phpGrammar.fileTypes.concat(typeList)

    phpGrammar.activate()

  deactivate: ->
    @drupalView.destroy()

  serialize: ->
    drupalViewState: @drupalView.serialize()
