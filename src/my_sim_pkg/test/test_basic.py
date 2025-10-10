import unittest
import rclpy

class TestNode(unittest.TestCase):
    def test_node_starts(self):
        rclpy.init()
        node = rclpy.create_node('test_node')
        self.assertIsNotNone(node)
        node.destroy_node()
        rclpy.shutdown()

if __name__ == '__main__':
    unittest.main()
