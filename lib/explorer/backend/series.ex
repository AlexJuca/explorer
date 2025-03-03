defmodule Explorer.Backend.Series do
  @moduledoc """
  The behaviour for series backends.
  """

  @type t :: %{__struct__: atom()}

  @type s :: Explorer.Series.t()
  @type df :: Explorer.DataFrame.t()
  @type dtype :: :integer | :float | :boolean | :string | :date | :datetime

  # Conversion

  @callback from_list(list(), dtype()) :: s
  @callback to_list(s) :: list()
  @callback cast(s, dtype) :: s

  # Introspection

  @callback dtype(s) :: dtype()
  @callback length(s) :: integer()

  # Slice and dice
  @callback head(s, n :: integer()) :: s
  @callback tail(s, n :: integer()) :: s
  @callback sample(s, n :: integer(), with_replacement :: boolean(), seed :: integer()) :: s
  @callback take_every(s, integer()) :: s
  @callback filter(s, mask :: s) :: s
  @callback filter(s, function()) :: s
  @callback slice(s, offset :: integer(), length :: integer()) :: s
  @callback take(s, indices :: list()) :: s
  @callback get(s, idx :: integer()) :: s

  # Aggregation

  @callback sum(s) :: number()
  @callback min(s) :: number() | Date.t() | NaiveDateTime.t()
  @callback max(s) :: number() | Date.t() | NaiveDateTime.t()
  @callback mean(s) :: float()
  @callback median(s) :: float()
  @callback var(s) :: float()
  @callback std(s) :: float()
  @callback quantile(s, float()) :: number | Date.t() | NaiveDateTime.t()

  # Cumulative

  @callback cum_max(s, reverse? :: boolean()) :: s
  @callback cum_min(s, reverse? :: boolean()) :: s
  @callback cum_sum(s, reverse? :: boolean()) :: s

  # Local minima/maxima

  @callback peaks(s, :max | :min) :: s

  # Arithmetic

  @callback add(s, s | number()) :: s
  @callback subtract(s, s | number()) :: s
  @callback multiply(s, s | number()) :: s
  @callback divide(s, s | number()) :: s
  @callback pow(s, number()) :: s

  # Comparisons

  @callback eq(s, s | number()) :: s
  @callback neq(s, s | number()) :: s
  @callback gt(s, s | number()) :: s
  @callback gt_eq(s, s | number()) :: s
  @callback lt(s, s | number()) :: s
  @callback lt_eq(s, s | number()) :: s
  @callback all_equal?(s, s) :: boolean()

  # Coercion

  # Sort

  @callback sort(s, reverse? :: boolean()) :: s
  @callback argsort(s, reverse? :: boolean()) :: s
  @callback reverse(s) :: s

  # Distinct

  @callback distinct(s) :: s
  @callback n_distinct(s) :: integer()
  @callback count(s) :: df

  # Rolling

  @callback rolling_sum(s, window_size :: integer(), weight :: float(), ignore_nil? :: boolean()) ::
              s
  @callback rolling_mean(s, window_size :: integer(), weight :: float(), ignore_nil? :: boolean()) ::
              s
  @callback rolling_min(s, window_size :: integer(), weight :: float(), ignore_nil? :: boolean()) ::
              s
  @callback rolling_max(s, window_size :: integer(), weight :: float(), ignore_nil? :: boolean()) ::
              s

  # Nulls

  @callback fill_missing(s, strategy :: :backward | :forward | :min | :max | :mean) :: s

  # Escape hatch

  @callback map(s, fun) :: s
end
