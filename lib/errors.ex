# ---
# Excerpted from "Thinking Elixir - CodeFlow", published by Mark Ericksen.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact me if you are in doubt. I make
# no guarantees that this code is fit for any purpose. Visit
# https://thinkingelixir.com/available-courses/code-flow/ for course
# information.
# ---
defmodule CodeFlow.Errors do
  @moduledoc """
  Fix or complete the code to make the tests pass.
  """
  alias CodeFlow.Fake.Orders
  alias CodeFlow.Fake.Users

  def find_user!(id) do
    case Users.find(id) do
      {:ok, user} ->
        user

      {:error, reason} ->
        raise reason
    end
  end

  def find_order(id) do
    {:ok, Orders.find!(id)}
  rescue
    e in RuntimeError ->
      {:error, e.message}
  end
end
