---
path: /learnings/learning_google_cloud_llm_vertex
title: Learning Google Cloud: LLMs (Vertex)
---
# Table of contents

<!-- toc -->

<!-- tocstop -->

# Chatbot use case

(This is a conversation with Gemini, have not verified it yet)

Could use Vertex AI, could also use Dialogflow.

A step-by-step guide to get you started:

1. Set Up Your Google Cloud Project:

    Create a Project: If you don't have one already, create a new Google Cloud project. This will be your workspace for all your chatbot development.
    Enable Vertex AI API: Make sure the Vertex AI API is enabled for your project. You can do this in the Google Cloud Console under "APIs & Services."
    Create a Vertex AI Endpoint: This is where you'll deploy your chatbot model. You can create an endpoint in the Vertex AI Studio.

2. Choose Your LLM:

    Vertex AI Generative AI: This is where you'll find Google's powerful LLMs like PaLM 2 and Gemini. These models are designed for natural language understanding and generation, making them ideal for chatbots.
    Model Selection: Consider the specific capabilities you need for your chatbot. For example, if you need a model that can handle complex conversations and generate creative text, Gemini Pro might be a good choice.

3. Design Your Chatbot's Flow:

    Intents and Entities: Define the different intents (user goals) your chatbot should understand, like "Book a Flight," "Get Weather," or "Ask for Support." Also, define entities (specific pieces of information), such as "Destination," "Date," or "City."
    Dialogue Flow: Create a flow that guides the conversation based on user input and intents. This could involve asking clarifying questions, providing information, or taking actions.

4. Prepare Your Training Data:

    Example Conversations: Gather a collection of example conversations that demonstrate how users might interact with your chatbot. This data will help your LLM learn the patterns of human language and how to respond appropriately.
    Data Format: Organize your training data in a format that's compatible with Vertex AI, such as JSON or CSV.


## How does the chatbot maintain conversational state?

 That's a great question! Chatbots maintain conversational state in a few key ways, and the specific methods depend on the platform and technology used. Here's a breakdown:

1. Contextual Memory:

    Multi-turn Chat: Modern LLMs like those in Vertex AI Generative AI are designed for multi-turn chat. This means they can track the history of a conversation and use that history as context for future responses.
    Prompt Engineering: You can explicitly guide the LLM by including the previous conversation turns within the prompt. For example, you might send a prompt like: "Previous conversation: User: 'What's the weather like?' Chatbot: 'It's sunny today.' User: 'What about tomorrow?'" This helps the LLM understand the context.

2. Dialogflow Contexts:

    Dialogflow's Built-in Feature: Dialogflow, a conversational AI platform on GCP, uses "Contexts" to manage conversational state. Contexts are essentially tags or labels that are attached to a conversation.
    Tracking Information: You can use Contexts to track information like the user's location, preferences, or the current stage of a task. This allows the chatbot to tailor its responses based on the context.

3. Webhooks and External Data:

    External Storage: You can use webhooks to connect your chatbot to external databases or services. This allows you to store conversational state in a more persistent way.
    Data Retrieval: When a user interacts with the chatbot, the webhook can retrieve the relevant context from the external data source and provide it to the LLM.

4. User IDs and Session Management:

    Unique Identifiers: If you're using a platform that allows for user authentication, you can use user IDs to track conversational state across multiple sessions.
    Session Variables: Some platforms allow you to store session variables that persist for the duration of a user's session.

## Deploying this

here are a few ways to bring a chatbot AI into your external website, and both iframes and JavaScript libraries are common approaches. Here's a breakdown:

### Dialogflow Messenger:

  * Google's Solution: Dialogflow Messenger is a Google Cloud service specifically designed for embedding chatbots into websites. It's a powerful and flexible option.
  * Integration: Dialogflow Messenger provides a customizable chat dialog that you can embed in your website using an iframe or a JavaScript snippet.
  * Customization: You can customize the appearance and behavior of the chat dialog to match your website's design.

Dialogflow CX can be integrated with Vertex AI Conversation to leverage the capabilities of LLMs for specific tasks within your conversational flow.

# See Also

  * [My article on Vertex AI with handwriting recognition for the Remarkable](https://blog.wilcoxd.com/2024/04/19/Remarkable-Handwriting-with-Vertex-AI/)
