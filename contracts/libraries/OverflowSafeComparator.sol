// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.6;

/// @title OverflowSafeComparator library to share comparator functions between contracts
/// @author PoolTogether Inc.
library OverflowSafeComparator {
  /// @notice 32-bit timestamps comparator.
  /// @dev safe for 0 or 1 overflows, `_a` and `_b` must be chronologically before or equal to time.
  /// @param _a A comparison timestamp from which to determine the relative position of `_timestamp`.
  /// @param _b Timestamp to compare against `_a`.
  /// @param _timestamp A timestamp truncated to 32 bits.
  /// @return bool Whether `_a` is chronologically < `_b`.
  function lt(
      uint32 _a,
      uint32 _b,
      uint32 _timestamp
  ) internal pure returns (bool) {
      // No need to adjust if there hasn't been an overflow
      if (_a <= _timestamp && _b <= _timestamp) return _a < _b;

      uint256 aAdjusted = _a > _timestamp ? _a : _a + 2**32;
      uint256 bAdjusted = _b > _timestamp ? _b : _b + 2**32;

      return aAdjusted < bAdjusted;
  }

  /// @notice 32-bit timestamps comparator.
  /// @dev safe for 0 or 1 overflows, `_a` and `_b` must be chronologically before or equal to time.
  /// @param _a A comparison timestamp from which to determine the relative position of `_timestamp`.
  /// @param _b Timestamp to compare against `_a`.
  /// @param _timestamp A timestamp truncated to 32 bits.
  /// @return bool Whether `_a` is chronologically <= `_b`.
  function lte(
      uint32 _a,
      uint32 _b,
      uint32 _timestamp
  ) internal pure returns (bool) {
      // No need to adjust if there hasn't been an overflow
      if (_a <= _timestamp && _b <= _timestamp) return _a <= _b;

      uint256 aAdjusted = _a > _timestamp ? _a : _a + 2**32;
      uint256 bAdjusted = _b > _timestamp ? _b : _b + 2**32;

      return aAdjusted <= bAdjusted;
  }
}
