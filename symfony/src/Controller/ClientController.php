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

use App\Entity\Client;
use App\Repository\ClientRepository;

class ClientController extends AbstractController
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
     * @Route("/client/{id}", name="client", methods={"GET"})
     */
    public function getClient($id): Response
    {
        $em = $this->em;
        $client = $em->getRepository(Client::class)->findById($id);

        if(empty($client)){
            return $this->returnKo();
        }

        $jsonContent = $this->serializer->serialize($client[0], 'json');

        $this->response->setContent($jsonContent);
        return $this->response;
    }

    /**
     * @Route("/client/", name="clients", methods={"GET"})
     */
    public function getAll(): Response
    {
        $em = $this->em;
        $client = $em->getRepository(Client::class)->findAll();

        if(empty($client)){
            return $this->returnKo();
        }

        $jsonContent = $this->serializer->serialize($client, 'json');

        $this->response->setContent($jsonContent);
        return $this->response;
    }

    /**
     * @Route("/client/create", name="client_create", methods={"POST"})
     */
    public function create(Request $request): Response
    {
        $em = $this->em;
        $data = json_decode($request->getContent(),true);
        if(empty($data)){
            return $this->returnKo();
        }

        // TODO map request data to desired entity dynamically
        $client = new Client();
        $client->setName($data['name']);
        $client->setSurname($data['surname']);
        $client->setEmail($data['email']);
        $client->setPhone($data['phone']);

        $em->persist($client);
        $em->flush();

        $jsonContent = $this->serializer->serialize($client, 'json');
        $this->response->setContent($jsonContent);
        return $this->response;
    }

    /**
     * @Route("/client/edit/{id}", name="client_edit", methods={"PUT"})
     */
    public function edit(int $id, Request $request): Response
    {
        $em = $this->em;
        $data = json_decode($request->getContent(),true);
        if(empty($data)){
            return $this->returnKo();
        }
        
        $client = $em->getRepository(Client::class)->findById($id);

        if(empty($client[0])){
            $this->returnKo();
        }

        // TODO map request data to desired entity dynamically
        $client[0]->setName($data['name']);
        $client[0]->setSurname($data['surname']);
        $client[0]->setEmail($data['email']);
        $client[0]->setPhone($data['phone']);

        $em->persist($client[0]);
        $em->flush();

        $jsonContent = $this->serializer->serialize($client[0], 'json');
        $this->response->setContent($jsonContent);
        return $this->response;
    }

    protected function returnKo(){
        $msg = json_encode(array(
            'success' => false,
            'message' => 'an error ocurred'
        ));
        $this->response->setContent($msg);
        $this->response->setStatusCode(Response::HTTP_NOT_ACCEPTABLE);
        return $this->response;
    }
}
