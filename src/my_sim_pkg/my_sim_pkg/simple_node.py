import rclpy
from rclpy.node import Node

class SimpleNode(Node):
    def __init__(self):
        super().__init__('simple_node')
        self.get_logger().info("✅ SimpleNode started successfully!")

def main(args=None):
    rclpy.init(args=args)
    node = SimpleNode()
    rclpy.spin_once(node, timeout_sec=2)
    node.destroy_node()
    rclpy.shutdown()

if __name__ == '__main__':
    main()
