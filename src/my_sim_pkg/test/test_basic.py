import pytest
import rclpy


def test_rclpy_import():
    """Simple test to verify rclpy is available."""
    assert rclpy is not None


def test_basic_math():
    """A dummy test to ensure pytest works."""
    assert 2 + 2 == 4
