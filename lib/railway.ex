# ---
# Excerpted from "Thinking Elixir - CodeFlow", published by Mark Ericksen.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact me if you are in doubt. I make
# no guarantees that this code is fit for any purpose. Visit
# https://thinkingelixir.com/available-courses/code-flow/ for course
# information.
# ---
defmodule CodeFlow.Railway do
  @moduledoc """
  Defining a workflow or "Code Flow" using the Railway Pattern.
  """
  alias CodeFlow.Schemas.User

  @doc """
  Works well when the functions are designed to pass the output of one
  step as the input of the next function.
  """
  def award_points(%User{} = user, inc_point_value) do
    user
    |> validate_is_active()
    |> validate_at_least_age(16)
    |> check_name_blacklist()
    |> increment_points(inc_point_value)
  end

  def validate_is_active(%User{active: true} = user) do
    {:ok, user}
  end

  def validate_is_active(user) do
    {:error, "Not an active User"}
  end

  def validate_at_least_age({:ok, %User{age: age} = user}, cutoff_age) when age >= cutoff_age do
    {:ok, user}
  end

  def validate_at_least_age({:ok, user}, cutoff_age) do
    {:error, "User age is below the cutoff"}
  end

  def validate_at_least_age(error, cutoff_age), do: {:error, "Wrong"}

  def check_name_blacklist({:ok, %User{name: name} = user}) do
    case name |> Enum.member?(["Tom", "Tim", "Tammy"]) do
      true -> {:error, "User #{inspect(name)} is blacklisted"}

      _ -> {:ok, "User #{inspect(name)} is not black listed"}
    end
  end

  def check_name_blacklist({:error, reason} = error), do: {:error, "Wrong"}

  def increment_points({:ok, %User{points: points} = user}, inc_by) do
    {:ok, %User{user | points: points + inc_by}}
  end

  def increment_points(error, inc_by), do: {:error, "Wrong"}
end
