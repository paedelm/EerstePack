EerstepackView = require './eerstepack-view'
{CompositeDisposable} = require 'atom'

module.exports = Eerstepack =
  eerstepackView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @eerstepackView = new EerstepackView(state.eerstepackViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @eerstepackView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'eerstepack:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @eerstepackView.destroy()

  serialize: ->
    eerstepackViewState: @eerstepackView.serialize()

  toggle: ->
    console.log 'Eerstepack was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
