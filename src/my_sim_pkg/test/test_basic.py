import pytest
import rclpy


def test_rclpy_import():
    """✅ Simple test to verify rclpy is available and initialized."""
    assert rclpy is not None, "❌ rclpy module not found"

def test_rclpy_init_shutdown():
    """✅ Test if rclpy initializes and shuts down correctly."""
    rclpy.init()
    assert rclpy.ok(), "❌ rclpy failed to initialize"
    rclpy.shutdown()
    assert not rclpy.ok(), "❌ rclpy failed to shut down properly"

def test_basic_math():
    """✅ A dummy test to ensure pytest works."""
    assert 2 + 2 == 4, "❌ Basic math failed"
