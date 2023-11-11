import React, {useRef} from 'react';
import {getAccessToken, MODEL_URL} from '../Model';

const QuestionStatistics: React.FC = () => {
	const iframeRef = useRef<HTMLIFrameElement | null>(null);

	return (
		<iframe
			ref={iframeRef}
			src={`${MODEL_URL}?token=${getAccessToken(iframeRef)}&redirect=question_statistics`}
			width="100%"
			height="100%"
			title="Model Iframe"
		></iframe>
	);
};

export default QuestionStatistics;
