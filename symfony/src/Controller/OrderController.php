<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\Routing\Annotation\Route;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Component\Serializer\Encoder\JsonEncoder;
use Symfony\Component\Serializer\Normalizer\ObjectNormalizer;
use Symfony\Component\Serializer\Serializer;

use App\Entity\Order;
use App\Entity\OrderDetail;
use App\Entity\Product;
use App\Entity\Client;
use App\Entity\Shop;
use App\Entity\Shopper;

class OrderController extends AbstractController
{
    private $repo;
    private $response;
    private $em;
    private $serializer;

    public function __construct(EntityManagerInterface $em) {
        $this->em = $em;

        $encoders = [new JsonEncoder()];
        $normalizers = [new ObjectNormalizer()];
        $this->serializer = new Serializer($normalizers, $encoders);

        $this->response = new JsonResponse(
            null,
            Response::HTTP_OK,
            ['content-type' => 'application/json']
        );
    }

    /**
     * @Route("/order/create", name="order_create", methods={"POST"})
     */
    public function create(Request $request): Response
    {
        $em = $this->em;
        $data = json_decode($request->getContent(),true);
        if(empty($data)){
            return $this->returnKo();
        }

        $order = new Order();
        $order->setPurchaseDate(new \DateTime($data['purchase_date']));
        $order->setDeliveryDate(new \DateTime($data['delivery_date']));
        $order->setIntervalDelivery($data['interval_delivery']);
        $order->setAmount($data['amount']);
        $order->setCompleted($data['completed']);
        $order->setAddress($data['address']);
        
        $client = $em->getRepository(Client::class)->findById($data['client_id_id']);
        $order->setClientId($client[0]);

        $em->persist($order);
        $em->flush();

        foreach($data['products'] as $k => $prod) {
            $product = new Product();
            $product->setName($prod['name']);
            $product->setDescription($prod['description']);
            $product->setUnits($prod['units']);
            $product->setPrice($prod['price']);
            
            $shop = $em->getRepository(Shop::class)->findById($prod['shop_id']);
            $product->setShop($shop[0]);

            $em->persist($product);
            $em->flush();

            $od = new OrderDetail();
            $od->setParentOrder($order);
            $od->setProduct($product);

            $em->persist($od);
            $em->flush();
        }

        $jsonContent = $this->serializer->serialize($order, 'json');
        $this->response->setContent($jsonContent);
        return $this->response;
    }

    /**
     * @Route("/shopper/orders", name="orders_by_shopper_and_shop", methods={"POST"})
     */
    public function getOrdersByShopper(Request $request): Response
    {
        $em = $this->em;
        $data = json_decode($request->getContent(),true);
        if(empty($data)){
            return $this->returnKo();
        }
 
        $shopper_id = $data['shopper_id'];
        $result = $em->getRepository(Shopper::class)->getOrdersByShopperAndShop($shopper_id);

        if(empty($result)){
            return $this->returnKo();
        }

        $output = array();
        if(!empty($result)){
            foreach($result as $k => $res){
                $order_id = $res['parent_order_id'];
                $output[$order_id]['Pedido'] = $res['parent_order_id'];
                $output[$order_id]['Fecha Realizacion'] = $res['purchase_date'];
                $output[$order_id]['Fecha Entrega'] = $res['delivery_date'];
                $output[$order_id]['Franja Horaria'] = $res['interval_delivery'];
                $output[$order_id]['Importe'] = $res['amount'];
                $output[$order_id]['Direccion'] = $res['address'];

                $p = [
                    'nombre' => $res['name'],
                    'descripcion' => $res['description'],
                    'cantidad' => $res['units'],
                    'precio' => $res['price']
                ];
                
                $output[$order_id]['Productos'][] = $p;
            }
        }

        $jsonContent = $this->serializer->serialize($output, 'json');
        $this->response->setContent($jsonContent);
        return $this->response;
    }
    
    protected function returnKo(){
        $msg = json_encode(array(
            'success' => false,
            'message' => 'no results provided'
        ));
        $this->response->setContent($msg);
        $this->response->setStatusCode(Response::HTTP_NOT_ACCEPTABLE);
        return $this->response;
    }
}
