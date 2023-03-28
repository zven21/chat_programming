defmodule ChatProgrammingWeb.PageLive do
    alias ChatProgramming.{Space, Card}

  use ChatProgrammingWeb, :live_view

  @impl true
  def mount(params, _session, socket) do
    spaces = Space.all()
    IO.puts inspect spaces
    space_names = Enum.map(spaces, &(&1.name))
    space_selected = Enum.at(spaces, 0)
    {:ok,
    assign(
      socket,
      form: to_form(%{}, as: :f),
      # spaces
      space_names: space_names,
      spaces: spaces,
      space_selected: space_selected
    )}
  end

  @impl true
  def handle_params(params, _uri, socket) do
    {:noreply, socket}
  end

  def handle_event("submit", params, socket) do
    {:noreply, socket}
  end

  def handle_event("change_space", %{"_target" => ["f", "space_name"], "f" => %{"space_name" => space_name}} = params, %{assigns: assigns} = socket) do
    space_selected = Space.get_by_name(space_name)
    IO.puts inspect space_selected

    {
      :noreply,
      socket
      |> assign(space_selected: space_selected)
    }
  end

  def handle_event(_others, params, socket) do
    {:noreply, socket}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <.form for={@form} phx-change="change_space" phx-submit="submit">
    <.container class="mt-10 mb-32">
      <.h3 label="" />
      <div>
        <%!-- <.dropdown label="Learning Space" js_lib="live_view_js">
          <.dropdown_menu_item type="a" to="/" label="Aptos" />
          <.dropdown_menu_item type="live_patch" to="/" label="Sui" />
          <.dropdown_menu_item type="live_redirect" to="/" label="React" />
        </.dropdown> --%>
      <.input field={@form[:space_name]} type="select" options={@space_names}/>
      <br>
      <.h5><%= @space_selected.description %></.h5>
      <br>
        <.input field={@form[:question]} placeholder="How can I learn this technical?" />
      <br>
        <.button color="pure_white" label="Get Answer ⏎" />
      </div>
      </.container>

      <.container class="mt-10">
        <.h2 underline label="Knowledge Cards" />
        <div class="grid gap-5 mt-5 md:grid-cols-2 lg:grid-cols-3">
          <%= for card <- @space_selected.card do %>
          <a href={"#{card.url}"} target="_blank">
            <.card variant="outline">
              <.card_content category={"#{@space_selected.name}"} heading={"#{card.title}"}>
                <%= card.context %>
              </.card_content>
            </.card>
          </a>
          <% end %>
        </div>
      </.container>
    </.form>
    """
  end
end
