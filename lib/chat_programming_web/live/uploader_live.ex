defmodule ChatProgrammingWeb.UploaderLive do
  use ChatProgrammingWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def render(assigns) do
    ~H"""
    render upload
    """
  end
end