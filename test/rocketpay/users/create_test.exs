defmodule Rocketpay.Users.CreateTest do
  use Rocketpay.DataCase, async: true

  alias Rocketpay.User
  alias Rocketpay.Users.Create

  describe "call/1" do
    # TODO: verificar motivo do age nulo

    test "when all params are valid, return an user" do
      params = %{
        name: "Cainã",
        nickname: "caina",
        email: "caina@email.com",
        password: "123456",
        age: 23
      }

      {:ok, %User{id: user_id}} = Create.call(params)
      user = Repo.get(User, user_id)

      assert %User{name: "Cainã", age: 23, id: ^user_id} = user
    end

    test "when there are invalid params, return an error" do
      params = %{
        name: "Cainã",
        nickname: "caina",
        email: "caina@email.com",
      }

      {:error, changeset} = Create.call(params)

      expect_response = %{
        password: ["can't be blank"],
        age: ["can't be blank"]
      }

      assert errors_on(changeset) == expect_response
    end
  end
end
